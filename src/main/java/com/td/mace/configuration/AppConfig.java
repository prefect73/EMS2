package com.td.mace.configuration;

import com.td.mace.converter.ProjectLeadsListToUserConverter;
import com.td.mace.converter.ProjectsListToProjectConverter;
import com.td.mace.converter.RoleToUserProfileConverter;
import com.td.mace.converter.WorkPackagesListToWorkPackageConverter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.core.env.Environment;
import org.springframework.format.FormatterRegistry;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.util.Locale;
import java.util.Properties;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.td.mace")
@PropertySource(value = { "classpath:application.properties" })
public class AppConfig extends WebMvcConfigurerAdapter {

	private static final Logger LOGGER = LoggerFactory.getLogger(AppConfig.class);

	@Autowired
	private Environment environment;

	@Autowired
	RoleToUserProfileConverter roleToUserProfileConverter;

	@Autowired
	ProjectLeadsListToUserConverter projectLeadsListToUserConverter;

	@Autowired
	ProjectsListToProjectConverter projectsListToProjectConverter;
	
	@Autowired
	WorkPackagesListToWorkPackageConverter workPackagesListToWorkPackageConverter;
	
	
	/**
	 * Configure ViewResolvers to deliver preferred views.
	 */
	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {

		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		registry.viewResolver(viewResolver);
	}

	/**
	 * Configure ResourceHandlers to serve static resources like CSS/ Javascript
	 * etc...
	 */
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/static/**").addResourceLocations(
				"/static/");
	}

	/**
	 * Configure Converter to be used. In our example, we need a converter to
	 * convert string values[Roles] to UserProfiles in newUser.jsp
	 */
	@Override
	public void addFormatters(FormatterRegistry registry) {
		registry.addConverter(roleToUserProfileConverter);
		registry.addConverter(projectLeadsListToUserConverter);
		registry.addConverter(projectsListToProjectConverter);
		registry.addConverter(workPackagesListToWorkPackageConverter);
	}

	/* Localization section is started */

	/**
	 * Configure MessageSource to lookup any validation/error message in
	 * internationalized property files
	 */
	@Bean
	public MessageSource messageSource() {
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasename("messages");
		messageSource.setDefaultEncoding("ISO-8859-15");// For German
		return messageSource;
	}

	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(localeChangeInterceptor());
	}

	@Bean(name = "localeChangeInterceptor")
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("language");
		return localeChangeInterceptor;
	}

	@Bean(name = "localeResolver")
	public LocaleResolver getLocaleResolver() {
		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
		if (environment.getProperty("default.language").equalsIgnoreCase(
				"german")) {
			cookieLocaleResolver.setDefaultLocale(Locale.GERMAN);
		} else if (environment.getProperty("default.language")
				.equalsIgnoreCase("english")) {
			cookieLocaleResolver.setDefaultLocale(Locale.ENGLISH);
		} else {
			cookieLocaleResolver.setDefaultLocale(Locale.GERMAN);
		}

		return cookieLocaleResolver;
	}

	    @Bean
   public JavaMailSenderImpl javaMailSenderImpl() {
		       final JavaMailSenderImpl mailSenderImpl = new JavaMailSenderImpl();

				        try {
			            mailSenderImpl.setHost(environment.getRequiredProperty("support.email.host"));
			            mailSenderImpl.setPort(environment.getRequiredProperty("support.email.port", Integer.class));
			            mailSenderImpl.setUsername(environment.getRequiredProperty("support.email.username"));
			            mailSenderImpl.setPassword(environment.getRequiredProperty("support.email.password"));
			        } catch (IllegalStateException ise) {
			            LOGGER.error("Could not resolve email.properties.  See email.properties.sample");
			            throw ise;
			        }
		        final Properties javaMailProps = new Properties();
		        javaMailProps.put("mail.smtp.auth", true);
		        javaMailProps.put("mail.smtp.starttls.enable", true);
		        mailSenderImpl.setJavaMailProperties(javaMailProps);
		        return mailSenderImpl;
		    }

	/**
	 * Optional. It's only required when handling '.' in @PathVariables which
	 * otherwise ignore everything after last '.' in @PathVaidables argument.
	 * It's a known bug in Spring [https://jira.spring.io/browse/SPR-6164],
	 * still present in Spring 4.1.7. This is a workaround for this issue.
	 */
	@Override
	public void configurePathMatch(PathMatchConfigurer matcher) {
		matcher.setUseRegisteredSuffixPatternMatch(true);
	}
}