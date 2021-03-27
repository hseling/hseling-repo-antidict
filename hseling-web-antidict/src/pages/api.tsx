import React from "react";
import './api.css';

export function Api() {
    const text = "curl -i -X POST \\ \n-H \"Content-Type: application/json; indent=4\" \\ \n-d '{ \n    \"jsonrpc\": \"2.0\", \n    \"method\": \"process_input_text\", \n    \"params\": {\"text\": \"Текст для обработки\"}, \n    \"id\": \"1\" \n}' http://localhost:5000/rpc/"
    return (
        <div className="api">
            <h2 style={{margin: '0 auto', textAlign: 'center'}}>Использование API</h2>
            <p>Для взаимодействия с Antidict в качестве API, необходимо использовать протокол
            JSON-RPC. Требуется формировать JSON сообщение соответствующего формата и отправлять
            его по адресу http://localhost:5000/rpc/ с помощью метода POST.</p>
            <p>Ниже приведен пример вызова API с помощью curl. Значение параметра "text" нужно заменить на
            текст, которые требуется обработать.</p>
            <pre>
                <code>
                    {text}
                </code>
            </pre>
        </div>
    );
}