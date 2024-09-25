import { telentConnection } from 'telnetconnection';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    telentConnection.echo({ value: inputValue })
}
