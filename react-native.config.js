module.exports = {
    dependencies: {
      'some-unsupported-package': {
        platforms: {
          ios: null, // disable Android platform, other platforms will still autolink if provided
        },
      },
    },
  };