extern crate mustache;
extern crate yaml_rust;

use mustache::MapBuilder;
use std::io::{self, Read, Write};
use std::{env, process};
use yaml_rust::YamlLoader;

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        let message = "Usage: mustache <template-file>";
        io::stderr().write_all(message.as_bytes()).unwrap();
        process::exit(1);
    }
    let template_path = &args[1];

    let mut input = String::new();
    io::stdin()
        .read_to_string(&mut input)
        .expect("Unable to read values from stdin");
    let docs = YamlLoader::load_from_str(&input).expect("Unable to parse YAML template values");
    let doc = &docs[0];

    let mut builder = MapBuilder::new();
    let hash = doc.as_hash().unwrap();
    for (k, v) in hash {
        let key = k.as_str().unwrap();
        let value = v.as_str().unwrap();
        builder = builder.insert_str(key, value);
    }
    let data = builder.build();

    let template = mustache::compile_path(template_path).unwrap();
    let stdout = io::stdout();
    let mut handle = stdout.lock();
    template
        .render_data(&mut handle, &data)
        .expect("Unable to render template to stdout")
}
