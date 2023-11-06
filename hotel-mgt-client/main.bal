import ballerina/log;
import ballerina/uuid;
import ballerina/http;
import ballerina/os;

public function main() returns error? {

    string clientId = os:getEnv("CLIENT_ID");
    string clientSecret = os:getEnv("CLIENT_SECRET");
    string tokenUrl = os:getEnv("TOKEN_URL");
    string serviceUrl = os:getEnv("SERVICE_URL");

    http:Client reserveClient = check new (
        url = serviceUrl,
        config = {
            auth: {
                clientId: clientId,
                clientSecret: clientSecret,
                clientConfig: {},
                tokenUrl: tokenUrl
            }
        }

    );

    log:printInfo("Making a reservation");
    uuid:Uuid uniqueId = check uuid:createType1AsRecord();
    string title = "hasitha - " + uniqueId.toString();
    Reservation resv = {
        title: title,
        hotelName: "Hotel Sigiriya",
        reservor: "Hasitha Abeykoon"
    };

    Reservation album = check reserveClient->/reservations.post(resv);
    log:printInfo("Successfully addded reservation. Reservation = " + album.toString());

    Reservation[] reservations = check reserveClient->/reservations;
    log:printInfo("GET ALL RESERVATIONS = " + reservations.toJsonString());
}
