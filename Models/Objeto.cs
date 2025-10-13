using Newtonsoft.Json;

namespace Culturi.Models
{
    public static class Objeto
    {
        // Convierte un objeto cualquiera a texto (JSON)
        public static string ObjectToString<T>(T obj)
        {
            return JsonConvert.SerializeObject(obj);
        }

        // Convierte un texto (JSON) a un objeto del tipo indicado
        public static T StringToObject<T>(string txt)
        {
            if (string.IsNullOrEmpty(txt))
                return default;
            else
                return JsonConvert.DeserializeObject<T>(txt);
        }
    }
}
