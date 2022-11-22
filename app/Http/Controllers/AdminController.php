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
        if (Auth::user()->user_is_admin === true)
            return view('admin.adminDashboard');
    }

    public function itemDashboard()
    {
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminItemsDashboard');
        }
    }

    public function userDashboard()
    {
        if (Auth::user()->user_is_admin === true) {
            $users = User::all();
            return view('admin.adminUsersDashboard', ['users' => $users]);
        }
    }

    public function userEditForm()
    {
        if (Auth::user()->user_is_admin === true) {
            return view('admin.adminEditUserForm',)->with("id_user", Request::get('id_user'));
        }
    }

    public function userEdit()
    {
        if (Auth::user()->user_is_admin === true) {
            $user = User::find(Request::post('id_user'));
            $user->name = Request::post('name');
            $user->save();
            return redirect('adminUsersDashboard');
        }
    }
}
