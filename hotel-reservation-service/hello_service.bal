import ballerina/http;

service /hello on new http:Listener(9091) {

    resource function get say() returns json {
        return {"message": "Hello, World!"};
    }
}
