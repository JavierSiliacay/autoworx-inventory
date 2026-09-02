"use client";

import { useState, useRef, useEffect } from "react";
import { MessageSquare, X, Send, Loader2, Minimize2, Maximize2, Trash2 } from "lucide-react";
import { motion, AnimatePresence } from "framer-motion";
import ReactMarkdown from "react-markdown";
import { usePathname } from "next/navigation";

type Message = {
  id: string;
  role: "user" | "assistant";
  content: string;
};

const SUGGESTIONS = ["Where is the inventory dashboard?", "Asa ang sales invoice?", "Unsaon pag print sa inventory list?"];
const WELCOME_MSG: Message = {
  id: "welcome",
  role: "assistant",
  content: "Hello! Ako si Primer AI. Pwede tika matabangan unsaon pag gamit sa Autoworx Inventory System. Unsa may matabang nako nimo karon? Pwede rajud ka magbisaya, makasabot raman japun ko.",
};

export default function PrimerAiChatWidget() {
  const pathname = usePathname();
  const [isOpen, setIsOpen] = useState(false);
  const [isMaximized, setIsMaximized] = useState(false);
  const [messages, setMessages] = useState<Message[]>([]);
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false);
  const [isInitialized, setIsInitialized] = useState(false);
  
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  };

  // Load from local storage on mount
  useEffect(() => {
    const saved = localStorage.getItem("primerAiHistory");
    if (saved) {
      try {
        setMessages(JSON.parse(saved));
      } catch (e) {
        setMessages([WELCOME_MSG]);
      }
    } else {
      setMessages([WELCOME_MSG]);
    }
    setIsInitialized(true);
  }, []);

  // Save to local storage on change
  useEffect(() => {
    if (isInitialized && messages.length > 0) {
      localStorage.setItem("primerAiHistory", JSON.stringify(messages));
    }
  }, [messages, isInitialized]);

  useEffect(() => {
    if (isOpen) {
      scrollToBottom();
    }
  }, [messages, isOpen]);

  const clearChat = () => {
    setMessages([WELCOME_MSG]);
    localStorage.removeItem("primerAiHistory");
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!input.trim() || isLoading) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      role: "user",
      content: input.trim(),
    };

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setIsLoading(true);

    const assistantMessageId = (Date.now() + 1).toString();
    setMessages((prev) => [
      ...prev,
      { id: assistantMessageId, role: "assistant", content: "" },
    ]);

    try {
      const recentHistory = messages
        .filter((m) => m.id !== "welcome" && m.content)
        .slice(-8)
        .map((m) => ({
          role: m.role,
          content: m.content,
        }));

      const res = await fetch("/api/primerai", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          prompt: userMessage.content,
          history: recentHistory,
          currentPath: pathname,
          stream: true,
        }),
      });

      if (!res.ok) throw new Error("Failed to fetch response");

      const reader = res.body?.getReader();
      const decoder = new TextDecoder();

      if (!reader) throw new Error("No reader");

      let done = false;
      let streamedText = "";

      while (!done) {
        const { value, done: readerDone } = await reader.read();
        done = readerDone;
        if (value) {
          const chunk = decoder.decode(value, { stream: true });
          
          // SSE format: data: {...}\n\n
          const lines = chunk.split("\n");
          for (const line of lines) {
            if (line.startsWith("data: ") && line !== "data: [DONE]") {
              try {
                const data = JSON.parse(line.slice(6));
                const contentChunk = data.choices?.[0]?.delta?.content || "";
                if (contentChunk) {
                  streamedText += contentChunk;
                  setMessages((prev) =>
                    prev.map((msg) =>
                      msg.id === assistantMessageId
                        ? { ...msg, content: streamedText }
                        : msg
                    )
                  );
                }
              } catch (e) {
                // Ignore incomplete JSON chunks, they will be handled
              }
            }
          }
        }
      }
    } catch (error) {
      console.error("Chat error:", error);
      setMessages((prev) =>
        prev.map((msg) =>
          msg.id === assistantMessageId
            ? { ...msg, content: "Sorry, I encountered an error. Please try again." }
            : msg
        )
      );
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <>
      <AnimatePresence>
        {!isOpen && (
          <motion.button
            initial={{ scale: 0, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0, opacity: 0 }}
            className="fixed bottom-6 right-6 z-50 flex h-16 w-16 items-center justify-center rounded-full bg-transparent shadow-2xl transition-transform hover:scale-110 active:scale-95 overflow-hidden border-2 border-white cursor-pointer"
            onClick={() => setIsOpen(true)}
          >
            <img 
              src="/worxai-icon-front.png" 
              alt="Primer AI" 
              className="w-full h-full object-cover"
            />
          </motion.button>
        )}
      </AnimatePresence>

      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, y: 20, scale: 0.95 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 20, scale: 0.95 }}
            className={`fixed z-50 flex flex-col overflow-hidden rounded-2xl border border-gray-200 bg-white shadow-2xl transition-all duration-300 ${
              isMaximized 
                ? "bottom-4 right-4 top-4 left-4 md:left-auto md:w-[600px]" 
                : "bottom-6 right-6 h-[600px] w-[400px] max-w-[calc(100vw-32px)]"
            }`}
          >
            {/* Header */}
            <div className="flex items-center justify-between bg-[#059669] px-4 py-3 text-white">
              <div className="flex items-center gap-3">
                <div className="relative h-8 w-8 overflow-hidden rounded-full bg-white/10 p-0.5">
                  <img src="/worxai-icon-front.png" alt="Primer AI" className="w-full h-full object-cover rounded-full" />
                </div>
                <div>
                  <h3 className="font-semibold leading-none">Primer AI</h3>
                  <span className="text-xs text-white/70">System Assistant</span>
                </div>
              </div>
              <div className="flex items-center gap-1">
                <button
                  onClick={clearChat}
                  title="Clear Chat"
                  className="rounded-md p-1.5 text-white/80 transition-colors hover:bg-white/20 hover:text-white"
                >
                  <Trash2 size={16} />
                </button>
                <button
                  onClick={() => setIsMaximized(!isMaximized)}
                  className="rounded-md p-1.5 text-white/80 transition-colors hover:bg-white/20 hover:text-white hidden md:block"
                >
                  {isMaximized ? <Minimize2 size={16} /> : <Maximize2 size={16} />}
                </button>
                <button
                  onClick={() => setIsOpen(false)}
                  className="rounded-md p-1.5 text-white/80 transition-colors hover:bg-white/20 hover:text-white"
                >
                  <X size={18} />
                </button>
              </div>
            </div>

            {/* Chat Area */}
            <div className="flex-1 overflow-y-auto relative bg-slate-50">
              <div className="absolute inset-0 z-0 flex items-center justify-center opacity-[0.30] pointer-events-none mix-blend-multiply">
                <img src="/worxai-icon-front.png" alt="Background" className="w-2/3 max-w-[250px] object-contain grayscale" />
              </div>
              <div className="flex flex-col gap-4 p-4 relative z-10">
                {messages.map((msg) => (
                  <div
                    key={msg.id}
                    className={`flex ${
                      msg.role === "user" ? "justify-end" : "justify-start"
                    }`}
                  >
                    <div
                      className={`max-w-[85%] rounded-2xl px-4 py-2.5 text-sm ${
                        msg.role === "user"
                          ? "bg-[#059669] text-white"
                          : "bg-white border border-gray-100 text-gray-800 shadow-sm"
                      }`}
                    >
                      <div className="max-w-none leading-relaxed text-inherit">
                        <ReactMarkdown
                          components={{
                            p: ({node, ...props}) => <p className="mb-2 last:mb-0" {...props} />,
                            strong: ({node, ...props}) => <strong className="font-bold" {...props} />,
                            ul: ({node, ...props}) => <ul className="list-disc pl-5 mb-2" {...props} />,
                            ol: ({node, ...props}) => <ol className="list-decimal pl-5 mb-2" {...props} />,
                            li: ({node, ...props}) => <li className="mb-1" {...props} />,
                            h1: ({node, ...props}) => <h1 className="text-lg font-bold mb-2 mt-3" {...props} />,
                            h2: ({node, ...props}) => <h2 className="text-base font-bold mb-2 mt-3" {...props} />,
                            h3: ({node, ...props}) => <h3 className="text-sm font-bold mb-2 mt-3" {...props} />,
                            a: ({node, ...props}) => <a className="text-[#005da7] font-semibold underline hover:text-[#2976c7] transition-colors cursor-pointer" {...props} />
                          }}
                        >
                          {msg.content}
                        </ReactMarkdown>
                      </div>
                    </div>
                  </div>
                ))}
                {isLoading && (
                  <div className="flex justify-start">
                    <div className="flex max-w-[85%] items-center gap-2 rounded-2xl bg-white border border-gray-100 px-4 py-3 text-sm shadow-sm text-gray-500">
                      <Loader2 className="h-4 w-4 animate-spin text-[#059669]" />
                      <span>Primer AI is thinking...</span>
                    </div>
                  </div>
                )}
                <div ref={messagesEndRef} />
              </div>
            </div>

            {/* Suggestion Chips */}
            {messages.length <= 1 && (
              <div className="bg-white px-3 pt-3 pb-2 flex gap-2 flex-wrap border-t border-gray-100">
                {SUGGESTIONS.map((sug, idx) => (
                  <button
                    key={idx}
                    onClick={() => setInput(sug)}
                    className="whitespace-nowrap flex-shrink-0 rounded-full bg-slate-50 border border-slate-200 px-3 py-1.5 text-xs text-slate-600 transition-colors hover:bg-slate-100 hover:text-slate-900"
                  >
                    {sug}
                  </button>
                ))}
              </div>
            )}

            {/* Input Area */}
            <div className="border-t border-gray-100 bg-white p-3">
              <form onSubmit={handleSubmit} className="flex items-center gap-2">
                <input
                  type="text"
                  value={input}
                  onChange={(e) => setInput(e.target.value)}
                  placeholder="Ask anything about the system..."
                  className="flex-1 rounded-full border border-gray-200 bg-white px-4 py-2.5 text-sm outline-none transition-colors focus:border-[#059669] focus:ring-1 focus:ring-[#059669]/20 relative z-10"
                  disabled={isLoading}
                />
                <button
                  type="submit"
                  disabled={!input.trim() || isLoading}
                  className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full bg-[#059669] text-white transition-transform hover:scale-105 active:scale-95 disabled:pointer-events-none disabled:opacity-50 relative z-10"
                >
                  <Send size={16} className="ml-0.5" />
                </button>
              </form>
            </div>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
