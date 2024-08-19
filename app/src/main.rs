use actix_files as fs;
use actix_web::{App, HttpServer, middleware::Logger};
use std::env;
use env_logger::Env;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    env_logger::init_from_env(Env::default().default_filter_or("info"));

    let server_address = env::var("SERVER_ADDRESS").unwrap_or_else(|_| "0.0.0.0".to_string());
    let server_port = env::var("SERVER_PORT").unwrap_or_else(|_| "8081".to_string());
    let image_directory = env::var("IMAGE_DIRECTORY").unwrap_or_else(|_| "./images".to_string());

    let bind_address = format!("{}:{}", server_address, server_port);

    log::info!("Starting server at http://{}", bind_address);
    log::info!("Serving files from: {}", image_directory);

    HttpServer::new(move || {
        App::new()
            .wrap(Logger::default())
            .service(fs::Files::new("/", &image_directory).index_file("index.html"))
    })
    .bind(&bind_address)?
    .run()
    .await
}
