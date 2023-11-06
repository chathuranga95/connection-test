import ballerina/http;

table<Reservation> key(title) reservations = table [
    {title: "booking-1", hotelName: "Amaya Hills", reservor: "Hasitha"},
    {title: "booking-2", hotelName: "Hilton", reservor: "Tishan"}
];

service / on new http:Listener(9090) {

    resource function get reservations() returns Reservation[] {
        return reservations.toArray();
    }

    resource function post reservations(Reservation reservation) returns Reservation {
        reservations.add(reservation);
        return reservation;
    }
}
