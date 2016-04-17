Sam.conversation = {};

Sam.previousQuestion = null;

Sam.conversation.init = function() {
    $(".chat-input .btn").click(function() {
        Sam.conversation.handleSend($(".chat-input input").eq(0).val());
    });

    $('.chat-input input').keyup(function(e){
        if(e.keyCode == 13) {
            Sam.conversation.handleSend($(".chat-input input").eq(0).val());
        }
    });

    setTimeout(function() {
        Sam.conversation.displayMessage("Hey there! Let's talk travel.", "sam");
    }, 1000);

    setTimeout(function() {
        Sam.conversation.displayMessage("What is your ideal trip?", "sam");
    }, 3000);
};

Sam.conversation.handleSend = function(message) {
    Sam.conversation.displayMessage(message);
    $(".chat-input input").val("");
    $.getJSON("/conversation/respond", {
        message: message,
        autorespond: 1,
        inResponseTo: Sam.previousQuestion
    }).done(function(data) {
        setTimeout(function() {
            Sam.conversation.handleResponse(data);
        }, 1000);
    });
};

Sam.conversation.handleResponse = function(response) {
    Sam.previousQuestion = response.code;
    Sam.conversation.displayMessage(response.message, 'sam');
};

Sam.conversation.displayMessage = function(message, from) {
    if(from == 'sam') {
        $(".messages").append('<div class="message-received"><div class="message-content">' + message + '</div></div>');
    } else {
        $(".messages").append('<div class="message-sent"><div class="message-content">' + message + '</div></div>');
    }
};
