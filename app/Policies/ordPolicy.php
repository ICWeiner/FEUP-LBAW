<?php

namespace App\Policies;

use App\Models\User;
use App\Models\ord;
use Illuminate\Auth\Access\HandlesAuthorization;
use Illuminate\Support\Facades\Auth;

class ordPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function viewAny(User $user)
    {
        return $user->user_is_admin;
    }

    /**
     * Determine whether the user can view the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\ord  $ord
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function view(User $user, ord $ord)
    {
        return $user->id_user === $ord->id_user;
    }

    /**
     * Determine whether the user can create models.
     *
     * @param  \App\Models\User  $user
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function create(User $user)
    {
        return Auth::check() && ( $user->user_is_admin === false || $user->user_is_admin === null );
    }

    /**
     * Determine whether the user can delete the model.
     *
     * @param  \App\Models\User  $user
     * @param  \App\Models\ord  $ord
     * @return \Illuminate\Auth\Access\Response|bool
     */
    public function delete(User $user, ord $ord)
    {
        //
    }

}
