// This is the server implementation for the unary blocking/unblocking scenario.
import ballerina/io;
import ballerina/grpc;

// The server endpoint configuration.
endpoint grpc:Listener ep {
    host:"localhost",
    port:9090
};

service HelloWorld bind ep {

    hello(endpoint caller, string name, grpc:Headers headers) {
        io:println("name: " + name);
        string message = "Hello " + name;
        // Working with custom headers.
        io:println(headers.get("Keep-Alive"));
        grpc:Headers resHeader = new;
        resHeader.setEntry("Host", "ballerina.io");
        error? err = caller->send(message, headers = resHeader);
        io:println(err.message but { () => "Server send response : " +
                                                                    message });
        _ = caller->complete();
    }
}
