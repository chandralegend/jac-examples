import:py requests;
import:py json;
import:py os;
import:py from jaclang.core.llms, Anthropic;

glob WEATHER_API_BASE_URL: str = "http://api.weatherapi.com/v1";
glob WEATHER_API_KEY: str = os.getenv("WEATHER_API_KEY", "");

can get_current_weather(city: str) -> str {
    url = f"{WEATHER_API_BASE_URL}/current.json?q={city}&key={WEATHER_API_KEY}";
    output = requests.get(url).json()["current"];
    return f"Current Weather in {city} is mentioned as {output["condition"]["text"]}";
}

can get_forecast(city: str, num_days: int) -> str {
    url = f"{WEATHER_API_BASE_URL}/forecast.json?q={city}&days={num_days}&key={WEATHER_API_KEY}";
    output = requests.get(url).json();
    current_weather = output["current"]["condition"]["text"];
    forecasts = output["forecast"]["forecastday"];
    weather_forecast = [
        f"Current Weather in {city} is mentioned as {current_weather}.",
        f"Weather Forecast for the next {num_days} days in {city} is as follows:"
    ];
    for day_forecast in forecasts {
        weather_forecast.append(f"- {day_forecast["date"]}: {day_forecast["day"]["condition"]["text"]}");
    }
    return "\n".join(weather_forecast);
}

glob llm = Anthropic(model_name="claude-3-sonnet-20240229");

glob examples: 'Question to Inputs Examples': list[dict] = [
    {
        "question": "What is the weather in New York?",
        "expected_output": ("get_current_weather", {"city": "New York"})
    },
    {
        "question": "I am going to New York for 3 days. Do I need to carry an umbrella?",
        "expected_output": ("get_forecast", {"city": "New York", "num_days": 3})
    }
];

can "Converts the Question into inputs for the API functions" 
question_to_inputs(question: 'Question Related to Weather': str) 
-> "function to use and inputs for the API functions": tuple(str, dict)
by llm(incl_info=(examples));

can "Answer the weather related questions in nice and comedic manner"
answer_weather_question(
    question: 'Question Related to Weather': str, 
    weather_info: 'Weather Information related to the Question': str
) -> "Answer to the question": str by llm();

can weather_question_answer(question: str) -> tuple {
    (function_name, inputs) = question_to_inputs(question);
    if function_name == "get_current_weather" {
        weather_info = get_current_weather(**inputs);
    } elif function_name == "get_forecast" {
        weather_info = get_forecast(**inputs);
    }
    return (weather_info, answer_weather_question(question, weather_info));
}

# with entry {
#     question = "I am going to Colombo tommorow for 4 days. Do I need to carry an umbrella?";
#     (weather_info, answer) = weather_question_answer(question);
#     print("Weather Information", weather_info);
#     print("Answer", answer);
# }