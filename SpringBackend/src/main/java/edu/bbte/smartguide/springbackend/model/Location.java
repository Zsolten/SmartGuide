package edu.bbte.smartguide.springbackend.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Location")
public class Location extends BaseEntity {
    @NotNull
    private String name;
    @NotNull
    private String city;
    @NotNull
    private String category;
    @NotNull
    private String description;
    @NotNull
    private String openHours;
    @NotNull
    private String prices;
    @NotNull
    private String googleMapsLink;
}
