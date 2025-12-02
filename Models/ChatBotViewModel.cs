using System.Collections.Generic;

namespace Culturi.Models
{
    public class ChatMessage
    {
        public string Content { get; set; }
        public bool IsUserMessage { get; set; }
    }

    public class ChatBotViewModel
    {
        public List<ChatMessage> History { get; set; }

        public ChatBotViewModel()
        {
            History = new List<ChatMessage>();
        }
    }
}
