package com.gabilon.bearstore.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
@Entity
public class Beer {

    @Id
    @SequenceGenerator(name="beer_seq", sequenceName = "beer_seq", allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "beer_seq")
    @EqualsAndHashCode.Include
    private Long id;

    @NotBlank(message = "beers-1")
    private String name;

    @NotNull(message = "beers-2")
    @DecimalMin(value = "0", message = "beers-3")
    private BigDecimal volume;

    @NotNull(message = "beers-4")
    private BeerType type;

    public enum BeerType {
        LAGER,
        PILSEN,
        IPA;
    }

}
