import { Box, createStyles, Text } from '@mantine/core';
import React from 'react';

/* TODO: WRAP A BORDER AROUND THE WHOLE BOX */

const useStyles = createStyles((theme) => ({
  container: {
    textAlign: 'center',
    // background: `linear-gradient(${theme.colors.black[5]}, ${theme.colors.black[5]}) padding-box, linear-gradient(90deg, #00ccff, #0051ff) border-box`,
    // borderLeft: `1px solid transparent`,
    // borderRight: `1px solid transparent`,
    // borderTop: `1px solid transparent`,
    borderTopLeftRadius: theme.radius.sm,
    borderTopRightRadius: theme.radius.sm,
    height: 'auto',
    width: 384,
    paddingTop: 20,
    paddingBottom: 25,
    display: 'grid',
    justifyContent: 'center',
    alignItems: 'center',
  },
  heading: {
    fontSize: 26,
    textTransform: 'uppercase',
    fontWeight: 700,
    marginBottom: 10,
  },
  line: {
    width: '100%',
    height: 3,
    background: `linear-gradient(to right, #00ccff, #0051ff)`,
  },
}));

const Header: React.FC<{ title: string }> = ({ title }) => {
  const { classes } = useStyles();

  return (
    <Box className={classes.container}>
      <Text className={classes.heading}>{title}</Text>
      <div className={classes.line} />
    </Box>
  );
};

export default React.memo(Header);
