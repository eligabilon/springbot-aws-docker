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

    @NotBlank
    private String name;

    @NotNull
    @DecimalMin("0")
    private BigDecimal volume;

    @NotNull
    private BeerType type;

    public enum BeerType {
        LAGER,
        PILSEN,
        IPA;
    }

}
