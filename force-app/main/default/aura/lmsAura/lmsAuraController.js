({
    handleMessage: function (component, message, helper) {
        console.log(message.getParam("lmsData").value);
        //component.set("attributename", value);
        component.set("v.messageReceived", message.getParam("lmsData").value);
    },

    handleChange: function (component, event, helper) {
        component.set("v.messageToPublish", component.find("txtMessage").get("v.value"));
    },

    handleClick: function (component, event, helper) {
        let msg = component.get("v.messageToPublish");
        const msgToPublish = {
            lmsData: {
                value: msg
            }
        }

        component.find("SimpleMessageChannel").publish(msgToPublish);

    },
})