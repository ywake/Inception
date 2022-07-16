const client = mqtt.connect('wss://ywake.42.fr:9000');

client.on('connect', function () {
	console.log('Connected');
	client.subscribe('test', function (err) {
		if (!err) {
			console.log('sub');
		}
	});
});

client.on('message', function (topic, payload, packet) {
	if (topic === 'test') {
		document.getElementById("customRange1").value = payload;
	}
});

client.on('close', function () {
	console.log('Disconnected')
});

function onMove(value) {
	client.publish('test', value);
};
