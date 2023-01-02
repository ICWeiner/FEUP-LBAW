<?php

namespace App\Http\Controllers\Auth;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Support\Facades\Password;

class ForgotPasswordController extends Controller
{

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

    public function getEmail(Request $request)
    {
        $this->validateEmail($request);

        $status = $this->broker()->sendResetLink(
            $this->credentials($request)
        );

        switch ($status)
        {
            case Password::RESET_LINK_SENT:
                return view('auth.passwords.email')->with('msg',"A recovery email has been sent to the provided address" );

            default:
                return view('auth.passwords.email')->withErrors(['msg' => "We can't find a user with that email address" ]);
        }
    }
}