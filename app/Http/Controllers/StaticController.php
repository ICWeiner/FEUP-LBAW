<?php

namespace App\Http\Controllers;


class StaticController extends Controller
{

    /**
     * Show the application about page.
     *
     */
    public function about()
    {
        return view('staticPages.about');
    }

    /**
     * Show the application services page.
     *
     */
    public function services()
    {
        return view('staticPages.services');
    }

    /**
     * Show the application faq page.
     *
     */
    public function faq()
    {
        return view('staticPages.faq');
    }

    /**
     * Show the application contact page.
     *
     */
    public function contact()
    {
        return view('staticPages.contact');
    }
}
