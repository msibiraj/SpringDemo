package com.example.demo.repo;

import com.example.demo.model.Users;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface UserRepo extends MongoRepository<Users, String> {
    Users findByUsername(String username);



}
