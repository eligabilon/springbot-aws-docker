package com.gabilon.bearstore.repository;

import com.gabilon.bearstore.model.Beer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface Beers extends JpaRepository<Beer, Long> {

}
