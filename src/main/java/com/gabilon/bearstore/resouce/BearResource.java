package com.gabilon.bearstore.resouce;

import com.gabilon.bearstore.model.Beer;
import com.gabilon.bearstore.repository.Beers;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@RestController
@RequestMapping("/beers")
public class BearResource {

    @Autowired
    private Beers beers;

    @GetMapping
    @ResponseStatus(HttpStatus.FOUND)
    public List<Beer> all() {
        return beers.findAll();
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)
    public Beer create(@Valid @RequestBody Beer beer){
        return beers.save(beer);
    }
}
