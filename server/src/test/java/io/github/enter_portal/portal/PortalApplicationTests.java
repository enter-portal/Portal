package io.github.enter_portal.portal;

import static org.assertj.core.api.Assertions.assertThat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;

import org.junit.jupiter.api.Test;

class PortalApplicationTests extends BaseIntegrationTest {

    @Autowired private ApplicationContext context;

    @Test
    void contextLoads() {
        assertThat(context).isNotNull();
    }

    @Test
    void shouldHaveBeanDefinitions() {
        assertThat(context.getBeanDefinitionCount()).isGreaterThan(0);
    }
}
