use leptos::prelude::*;
use leptos_meta::{provide_meta_context, MetaTags, Stylesheet, Title};
use leptos_router::{
    components::{Route, Router, Routes},
    StaticSegment,
};

pub fn shell(options: LeptosOptions) -> impl IntoView {
    view! {
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <AutoReload options=options.clone() />
                <HydrationScripts options/>
                <MetaTags/>
            </head>
            <body>
                <App/>
            </body>
        </html>
    }
}

#[component]
pub fn App() -> impl IntoView {
    // Provides context that manages stylesheets, titles, meta tags, etc.
    provide_meta_context();

    view! {
        // injects a stylesheet into the document <head>
        // id=leptos means cargo-leptos will hot-reload this stylesheet
        <Stylesheet id="leptos" href="/pkg/cim.css"/>

        // sets the document title
        <Title text="cim"/>

        // content for this welcome page
        <Router>
            <main>
                <Routes fallback=|| "Page not found.".into_view()>
                    <Route path=StaticSegment("") view=HomePage/>
                </Routes>
            </main>
        </Router>
    }
}

/// Renders the home page of your application.
#[component]
fn HomePage() -> impl IntoView {
    view! {
          <Header/>
          <div id="main">
            <Article>
                <h1>"Welcome to Cowboy AI"</h1>
                <p>"The future is now."</p>
            </Article>
            <Nav/>
            <Aside>
                <a href="#">"Contextual Links"</a>
            </Aside>
          </div>
          <footer>"Copyright (c) 2025 - Cowboy AI"</footer>
    }
}

#[component]
fn Nav() -> impl IntoView {
    view! {
        <nav>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/about">About</a></li>
                <li><a href="/contact">Contact</a></li>
            </ul>
        </nav>
    }
}

#[component]
fn Aside(children: Children) -> impl IntoView {
    view! {
        <aside>
            {children()}
        </aside>
    }
}

#[component]
fn Article(children: Children) -> impl IntoView {
    view! {
        <article>
            {children()}
        </article>
    }
}

#[component]
fn Header() -> impl IntoView {
    view! {
    <header><Logo/></header>    }
}

#[component]
fn Logo() -> impl IntoView {
    view! {
        <img src="./public/logo.svg" />
    }
}
