<?php

namespace App\Policies;

use App\Models\User;
use App\Models\ord;

use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class ordPolicy
{
    use HandlesAuthorization;

    public function view(User $user, ord $ord)
    {
      // Only an order owner can see it
      return $user->id_user === $ord->id_user;
    }

    public function list(User $user)
    {
      // Any user can list its own orders
      return Auth::check();
    }

    public function create(User $user)
    {
      // Any user can create a new order
      return Auth::check();
    }
}
