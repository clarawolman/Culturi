using Microsoft.AspNetCore.Mvc;
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.ChatCompletion;
using Microsoft.SemanticKernel.Connectors.Google;
using Microsoft.Extensions.Configuration;

namespace Culturi.Controllers
{
    public class ChatBotController : Controller
    {
        private readonly IChatCompletionService _chatService;
        private readonly ChatHistory _history;

        public ChatBotController(IConfiguration config)
        {
            string apiKey = config["GoogleAI:ApiKey"];

            var builder = Kernel.CreateBuilder();

            builder.AddGoogleAIGeminiChatCompletion(
                modelId: "gemini-2.5-flash",
                apiKey: apiKey
            );

            var kernel = builder.Build();

            _chatService = kernel.GetRequiredService<IChatCompletionService>();

            _history = new ChatHistory();
            _history.AddSystemMessage(
                "Sos un asistente en español. Respondé de forma breve, clara y amable."
            );
        }

        // GET: ChatBot
        [HttpGet]
        public IActionResult ChatBot()
        {
            return View();
        }

        // POST: ChatBot
        [HttpPost]
        public async Task<IActionResult> ChatBot(string userMessage)
        {
            if (!string.IsNullOrEmpty(userMessage))
            {
                _history.AddUserMessage(userMessage);

                var reply = await _chatService.GetChatMessageContentAsync(_history);

                _history.AddAssistantMessage(reply.ToString());

                ViewBag.Reply = reply.ToString();
            }

            return View(); // ahora sí vuelve a ChatBot.cshtml
        }
    }
}

