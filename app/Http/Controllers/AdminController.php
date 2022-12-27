<?php

namespace App\Http\Controllers;

use App\Models\User;
use Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Input;


class AdminController extends Controller
{

    public function dashboard()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true)
            return view('admin.adminDashboard');
    }

    public function itemDashboard()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminItemsDashboard');
        }
    }

    public function userDashboard()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            $users = User::all();
            return view('admin.adminUsersDashboard', ['users' => $users]);
        }
    }

    public function userEditForm()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminEditUserForm',)->with("id_user", Request::get('id_user'));
        }
    }

    public function userEdit()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            $user = User::find(Request::post('id_user'));
            $user->name = Request::post('name');
            $user->save();
            return redirect('adminUsersDashboard');
        }
    }

    public function banUser()
    {
        if (!Auth::check()) return redirect('/login');
        if (Auth::user()->user_is_admin === true) {
            $user = User::find(Request::post('id_user'));
            if($user->user_is_banned === null || $user->user_is_banned === false){
                $user->user_is_banned = true;
            }
            else{
                $user->user_is_banned = false;
            }   
            $user->save();
            return redirect('adminUsersDashboard');
        }
    }
}
