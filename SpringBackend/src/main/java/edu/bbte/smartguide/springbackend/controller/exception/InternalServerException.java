package edu.bbte.smartguide.springbackend.controller.exception;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
@Data
@AllArgsConstructor
public class InternalServerException extends RuntimeException {
    private String message;
}
