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
    public function show()
    {
        //
        #if (Auth::check())
        $user = Auth::user();
        return view('pages.user', ['user' => $user]);
        #}
    }

    public function showOrders()
    {
        $user = Auth::user();
        return view('pages.orders', ['user' => $user]);
    }


    public function showEditForm()
    {
        //
        #if (Auth::check()) { TODO: change this, or else users will see other users :^)
        $user = Auth::user();
        return view('pages.userEdit', ['user' => $user]);
        #}
    }

    public function edit(Request $request)
    {

        /*if($request['email'] === ''){ TODO: Make fields optional, maybe make a seperate page for each field?
            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'password'  => 'required|string|min:6|confirmed'
            ]);
        }else{
            $this->validate($request, [
                'name'      => 'required|string|max:255',
                'email'     => 'required|string|email|max:255|unique:users',
                'password'  => 'required|string|min:6|confirmed'
            ]);
        }*/

        $this->validate($request, [
            'name'      => 'required|string|max:255',
            'email'     => 'required|string|email|max:255|unique:users',
            'password'  => 'required|string|min:6|confirmed'
        ]);

        $user = Auth::user();
        $user->name     = $request->get('name');
        $user->email    = $request->get('email');
        if ($request->get('password') !== '') {
            $user->password = bcrypt($request->get('password'));
        }
        $user->update();

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
