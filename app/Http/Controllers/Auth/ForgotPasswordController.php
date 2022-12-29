<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Support\Facades\Password;

class ForgotPasswordController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Password Reset Controller
    |--------------------------------------------------------------------------
    |
    | This controller is responsible for handling password reset emails and
    | includes a trait which assists in sending these notifications from
    | your application to your users. Feel free to explore this trait.
    |
    */
    use SendsPasswordResetEmails;
    
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest');
    }

    public function showEmailForm(){
        return view('auth.forgotPassword');
    }
    

    public function getEmail(Request $request)
    {
        $this->validate($request, ['email' => 'required|email']);

        $status = Password::sendResetLink(
            $request->only('email')
        );

        switch ($status)
        {
            case Password::RESET_LINK_SENT:
                return view('auth.forgotPassword')->with('msg',"We can't find a user with that email address" );

            default:
                return view('auth.forgotPassword')->withErrors(['msg' => "We can't find a user with that email address" ]);
        }
    }
}