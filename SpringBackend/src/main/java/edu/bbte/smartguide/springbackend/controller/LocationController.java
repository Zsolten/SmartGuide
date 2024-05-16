package edu.bbte.smartguide.springbackend.controller;

import edu.bbte.smartguide.springbackend.controller.exception.InternalServerException;
import edu.bbte.smartguide.springbackend.dao.LocationDao;
import edu.bbte.smartguide.springbackend.dto.incoming.*;
import edu.bbte.smartguide.springbackend.dto.outgoing.*;
import edu.bbte.smartguide.springbackend.mapper.LocationMapper;
import edu.bbte.smartguide.springbackend.model.Location;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Collection;

@RestController
@RequestMapping("/location")
public class LocationController {
    @Autowired
    private LocationDao locationDao;

    @Autowired
    private LocationMapper locationMapper;

    @GetMapping
    public Collection<LocationOutDto> getAllLocations(@RequestParam(required = false) String name) {
        if (name != null) {
            return locationMapper.dtosFromLocations(locationDao.findByName(name));
        }
        return locationMapper.dtosFromLocations(locationDao.findAll());
    }

    @PostMapping
    public LocationOutDto createLocation(@RequestBody @Valid LocationInDto locationDto) {
        Location location = locationDao.saveAndFlush(locationMapper.locationFromDto(locationDto));

        if (location == null) {
            throw new InternalServerException(">> Inserting ERROR");
        } else {
            return locationMapper.dtoFromLocation(location);
        }
    }
}
