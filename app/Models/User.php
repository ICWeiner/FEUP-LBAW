<?php

namespace App\Models;

use Illuminate\Notifications\Notifiable;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable
{
    use Notifiable;

    // Don't add create and update timestamps in database.
    public $timestamps  = false;



    /**
     * The primary key associated with the table.
     *
     * @var string
     */
    protected $primaryKey = 'id_user';

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password', 'user_is_banned', 'user_is_admin',
    ];

    protected $casts = [
        'name' => 'string',
        'email' => 'string',
        'user_is_banned' => 'boolean',
        'user_is_admin' => 'boolean',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', #'remember_token', #TODO: figure this out
    ];


    public function orders()
    {
        return $this->hasMany('App\Models\ord');
    }

    public function comments()
    {
        return $this->hasMany('App\Models\comment');
    }

    public function reviews()
    {
        return $this->hasMany('App\Models\review');
    }

    public function address()
    {
        return $this->hasOne('App\Models\addressBook');
    }

    public function paymentInfo()
    {
        return $this->hasOne('App\Models\paymentInfo');
    }

    public function banned()
    {
        return $this->hasMany('App\Models\banned');
    }
}
