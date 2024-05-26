import { writable } from 'svelte/store';

export const user = writable({
    userId: null,
    userName: '',
    email: '',
    firstName: '',
    lastName: '',
    dateOfBirth: 0,
    description: '',
    avatar: '',
    isAdmin: 0
});