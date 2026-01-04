// El 'handler' es la función que AWS Lambda llamará automáticamente
exports.handler = async (event) => {
    
    // 1. Imprimimos el evento en los logs (CloudWatch) para ver los datos del archivo de S3
    console.log("Evento recibido de S3:", JSON.stringify(event, null, 2));

    // 2. Extraemos el nombre del bucket y el nombre del archivo (Key)
    // Nota: Step Functions pasa el evento de S3 a la Lambda
    const bucketName = event.detail.bucket.name;
    const fileName = event.detail.object.key;

    console.log(`Procesando archivo: ${fileName} desde el bucket: ${bucketName}`);

    // 3. Respuesta que recibirá la Step Function para saber que terminó con éxito
    return {
        statusCode: 200,
        message: "Septa Processor ejecutado correctamente",
        fileProcessed: fileName
    };
};