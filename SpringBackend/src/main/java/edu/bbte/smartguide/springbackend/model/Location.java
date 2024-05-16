package edu.bbte.smartguide.springbackend.model;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import lombok.*;

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
    private String googleMapsLink;
}
