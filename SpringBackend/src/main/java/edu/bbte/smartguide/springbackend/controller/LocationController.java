package edu.bbte.smartguide.springbackend.controller;

import edu.bbte.smartguide.springbackend.controller.exception.InternalServerException;
import edu.bbte.smartguide.springbackend.controller.exception.NotFoundException;
import edu.bbte.smartguide.springbackend.dao.LocationDao;
import edu.bbte.smartguide.springbackend.dto.incoming.*;
import edu.bbte.smartguide.springbackend.dto.outgoing.*;
import edu.bbte.smartguide.springbackend.mapper.LocationMapper;
import edu.bbte.smartguide.springbackend.model.Location;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
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
            throw new InternalServerException(">> Inserting ERROR ");
        } else {
            return locationMapper.dtoFromLocation(location);
        }
    }

    @PutMapping("/{id}")
    public void update(@RequestBody @Valid LocationInDto locationInDto, @PathVariable("id") Long id) {
        try {
            Location location = locationMapper.locationFromDto(locationInDto);

            if (locationDao.getById(id) == null) {
                throw new EntityNotFoundException();
            } else {
                location.setId(id);
                locationDao.saveAndFlush(location);
            }
        } catch (EntityNotFoundException e) {
            throw new NotFoundException(">> Updateing ERROR: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public LocationOutDto findById(@PathVariable("id") Long id) {
        try {
            Location result = locationDao.getById(id);
            if (result == null) {
                throw new EntityNotFoundException();
            } else {
                return locationMapper.dtoFromLocation(result);
            }
        } catch (EntityNotFoundException e) {
            throw new NotFoundException(">> Find By ID ERROR: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public void deleteById(@PathVariable("id") Long id) {
        try {
            Location result = locationDao.getById(id);
            if (id == null || result == null) {
                throw new EntityNotFoundException();
            } else {
                locationDao.deleteById(id);
            }
        } catch (EntityNotFoundException e) {
            throw new NotFoundException(">> Delete ERROR: " + e.getMessage());
        }
    }
}
