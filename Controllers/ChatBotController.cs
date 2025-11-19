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
            // 1. Obtener la API key de Google Gemini desde appsettings.json
            string apiKey = config["GoogleAI:ApiKey"];

            // 2. Crear el kernel
            var builder = Kernel.CreateBuilder();

            builder.AddGoogleAIGeminiChatCompletion(
                modelId: "gemini-2.5-flash",
                apiKey: apiKey
            );

            var kernel = builder.Build();

            // 3. Setear el servicio de chat
            _chatService = kernel.GetRequiredService<IChatCompletionService>();

            // 4. Inicializar un historial de conversación
            _history = new ChatHistory();
            _history.AddSystemMessage(
                "Sos un asistente en español. Respondé de forma breve, clara y amable."
            );
        }

        [HttpGet]
        public IActionResult ChatBot()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Index(string userMessage)
        {
            if (!string.IsNullOrEmpty(userMessage))
            {
                // Guardar mensaje del usuario
                _history.AddUserMessage(userMessage);

                // Obtener respuesta del modelo
                var reply = await _chatService.GetChatMessageContentAsync(
                    _history
                );

                // Guardar mensaje del asistente
                _history.AddAssistantMessage(reply.ToString());

                ViewBag.Reply = reply.ToString();
            }

            return View();
        }
    }
}
