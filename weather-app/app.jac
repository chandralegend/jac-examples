import:py streamlit as st;
import:jac from weather, weather_question_answer;

can main {
    st.title('Weather Bot');
    st.write('Ask me any weather related questions and I will try to answer them!');

    question = st.text_input('Enter Your Weather related Questions', 'What is the weather in New York?');
    if st.button("Ask Away!") and question {
        with st.spinner("I'm finding the answer for you..."){
            (weather_info, answer) = weather_question_answer(question);
        }
        st.write(weather_info);
        st.success(answer);
    } else {
         st.error('Please enter a question to get started!');
    }  
}
