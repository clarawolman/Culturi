/*using Microsoft.AspNetCore.Mvc;
using Google.AI.Generativelanguage.V1;
using Google.AI.Generativelanguage.V1BETA;
using Google.Api.Gax.Grpc;

namespace Culturi.Controllers
{
    public class ChatBotController : Controller
    {
        private readonly string _apiKey;
        private readonly GenerativeServiceClient _client;

        public ChatBotController(IConfiguration config)
        {
            _apiKey = config["GoogleAI:ApiKey"];

            var builder = new GenerativeServiceClientBuilder
            {
                ApiKey = _apiKey,
            };

            _client = builder.Build();
        }

        [HttpGet]
        public IActionResult ChatBot()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> ChatBot(string userMessage)
        {
            if (!string.IsNullOrEmpty(userMessage))
            {
                var request = new GenerateContentRequest
                {
                    Model = "models/gemini-1.5-flash",
                    Contents =
                    {
                        new Content
                        {
                            Role = "user",
                            Parts = { new Part { Text = userMessage } }
                        }
                    }
                };

                var response = await _client.GenerateContentAsync(request);

                var reply = response.Candidates.First().Content.Parts.First().Text;

                ViewBag.Reply = reply;
            }

            return View();
        }
    }
} */
