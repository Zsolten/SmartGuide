package edu.bbte.smartguide.springbackend.dto.incoming;

import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.NonNull;

@Data
public class LocationInDto {
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
