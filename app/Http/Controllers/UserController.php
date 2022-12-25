<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show()
    {
        //
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();
        return view('pages.user', ['user' => $user]);
        #}
    }

    public function showOrders()
    {
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();
        return view('pages.orders', ['user' => $user]);
    }


    public function showEditForm()
    {
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();
        return view('pages.userEdit', ['user' => $user]);
        #}
        $request->session()->invalidate();   
    }

    public function edit(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $this->validate($request, [
            'name'      => 'required|string|max:255',
            'email'     => 'required|string|email|max:255|unique:users',
            'password'  => 'required|string|min:6|confirmed',
            'image'     => 'image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);


        $user = Auth::user();

        if ( $request->image !== null){
            $imageName = time().'.'.$request->image->extension();   
            $request->image->move(public_path('images/users'), $imageName);

            $user->image ='images/users/'.$imageName;
        }

        $user->name     = $request->get('name');
        $user->email    = $request->get('email');
        if ($request->get('password') !== '') {
            $user->password = bcrypt($request->get('password'));
        }
        $user->update();

        return redirect('products');
    }


    /**
     * Remove the specified resource from storage.
     *
     *
     * @return \Illuminate\Http\Response
     */
    public function destroy(Request $request)
    {
        if (!Auth::check()) return redirect('/login');
        $user = Auth::user();
        $user->name  = "deleted";
        $user->email = "deleted" . $user->id_user;
        $user->update();


        auth()->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect()->route('home');
    }
}
