<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function show(User $user) #TODO: this function should return a view that has an overview of user info
    {
        //
        #if (Auth::check()) { TODO: change this, or else users will see other users :^)
        return view('pages.user', ['user' => $user]);
        #}
    }

    public function showEditForm(User $user)
    {
        //
        #if (Auth::check()) { TODO: change this, or else users will see other users :^)
        return view('pages.user', ['user' => $user]);
        #}
    }

    public function edit(User $user, Request $request)
    {
        $this->validate($request, [
            'name'      => 'required|string|max:255',
            'email'     => 'required|string|email|max:255|unique:users',
            'password'  => 'required|string|min:6|confirmed'
        ]);

        $user->name     = $request->get('name');
        $user->email    = $request->get('email');
        if ($request->get('password') !== '') {
            $user->password = $request->get('password');
        }
        $user->save();

        return redirect('products');

        /*return redirect('/todo')
            ->with('flash_notification.message', 'Profile updated successfully')
            ->with('flash_notification.level', 'success');*/
    }


    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Http\Response
     */
    public function destroy(User $user)
    {
        //
    }
}
