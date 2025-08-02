import React from 'react';
import { Box, createStyles, Text, Progress } from '@mantine/core';
import { useNuiEvent } from '../../hooks/useNuiEvent';
import { fetchNui } from '../../utils/fetchNui';
import ScaleFade from '../../transitions/ScaleFade';
import type { ProgressbarProps } from '../../typings';

const useStyles = createStyles((theme) => ({
  container: {
    width: 350,
    height: 45,
    background: `linear-gradient(${theme.colors.black[5]}, ${theme.colors.black[5]}) padding-box, linear-gradient(90deg, #00ccff, #0051ff) border-box`,
    border: '1px solid transparent',
    borderRadius: theme.radius.sm,
    backgroundColor: theme.colors.black2[5],
    overflow: 'hidden',
    position: 'relative',
    display: 'flex',
    alignItems: 'center',
    paddingLeft: 15,
    paddingRight: 15,
  },
  wrapper: {
    width: '100%',
    height: '20%',
    display: 'flex',
    flexDirection: 'column', // Stack label above the bar
    alignItems: 'center',
    justifyContent: 'center',
    bottom: 0,
    position: 'absolute',
  },
  bar: {
    height: '40%',
    borderRadius: theme.radius.sm,
    background: `linear-gradient(to right, #00ccff, #0051ff)`,
    transition: 'width 0.5s ease',
    position: 'relative',
    zIndex: 1, // <-- put the bar behind the track

  },
  track: {
    position: 'absolute',
    top: 'calc(30% - 0.5px)',
    left: 15,
    right: 15,
    height: 'calc(40% + 1px)',
    borderRadius: theme.radius.sm,
    background: 'transparent',
    pointerEvents: 'none',
    zIndex: 2,
    '&::before': {
      content: '""',
      position: 'absolute',
      inset: 0,
      borderRadius: theme.radius.sm,
      padding: 1, // thickness of the border
      background: `linear-gradient(90deg, #0051ff, #00ccff)`,
      WebkitMask: 'linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0)',
      WebkitMaskComposite: 'xor',
      maskComposite: 'exclude',
    },
  },

  labelWrapper: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
  },
  label: {
    maxWidth: 350,
    textOverflow: 'ellipsis',
    overflow: 'hidden',
    whiteSpace: 'nowrap',
    fontSize: 18,
    fontWeight: 500,
    color: theme.colors.white[5],
    textShadow: theme.shadows.sm,
  },
}));

const Progressbar: React.FC = () => {
  const { classes } = useStyles();
  const [visible, setVisible] = React.useState(false);
  const [label, setLabel] = React.useState('');
  const [duration, setDuration] = React.useState(0);

  useNuiEvent('progressCancel', () => setVisible(false));

  useNuiEvent<ProgressbarProps>('progress', (data) => {
    setVisible(true);
    setLabel(data.label);
    setDuration(data.duration);
  });

  return (
    <Box className={classes.wrapper}>
      <ScaleFade visible={visible} onExitComplete={() => fetchNui('progressComplete')}>
        <Box className={classes.labelWrapper}>
          <Text className={classes.label}>{label}</Text>
        </Box>
        <Box className={classes.container}>
          {/* Inner track border */}
          <Box className={classes.track} />

          {/* Existing animated progress bar */}
          <Box
            className={classes.bar}
            onAnimationEnd={() => setVisible(false)}
            sx={{
              animation: 'progress-bar linear',
              // animationDuration: `${duration}ms`,
              animationDuration: `5000ms`,
            }}
          />
        </Box>
      </ScaleFade>
    </Box>
  );
};

export default Progressbar;
