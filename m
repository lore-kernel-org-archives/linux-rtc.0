Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56570 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752348AbdK3O2O (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 30 Nov 2017 09:28:14 -0500
Date: Thu, 30 Nov 2017 14:27:48 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Patrick =?iso-8859-1?Q?Br=FCnn?= <P.Bruenn@beckhoff.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] rtc: add mxc driver for i.MX53
Message-ID: <20171130142748.GD10595@n2100.armlinux.org.uk>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171129221114.GV21126@piout.net>
 <CAOFm3uFb8Jo9detD2CziuYt_DH_ohYD9P=uvqHugKDxpN+xvAQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531330@NT-Mail07.beckhoff.com>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Thu, Nov 30, 2017 at 01:36:22PM +0000, Patrick Brünn wrote:
> >From: Philippe Ombredanne [mailto:pombredanne@nexb.com]
> >Sent: Donnerstag, 30. November 2017 09:18
> >>
> >>> +/*
> >>> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> >Reserved.
> >>> + */
> >>> +
> >>> +/*
> >>> + * The code contained herein is licensed under the GNU General Public
> >>> + * License. You may obtain a copy of the GNU General Public License
> >>> + * Version 2 or later at the following locations:
> >>> + *
> >>> + * http://www.opensource.org/licenses/gpl-license.html
> >>> + * http://www.gnu.org/copyleft/gpl.html
> >>> + */
> >
> >Exactly!
> >And while you are it , you could replace the boilerplate license text
> >with the SPDX id.
> >--
> 
> How would a perfect header look like?
> Looking at :
> git show b24413180f5600bcb3bb70fbed5cf186b60864bd -- drivers/
> and:
> git grep SPDX -- Documentation/
> 
> it could be:
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> or:
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + */
> 
> Personally I would prefer:
> +/*
> + * Copyright (C) 2004-2011 Freescale Semiconductor, Inc. All Rights
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> 
> So, is there any guideline?

There's been lots of discussion about this, but Linus T has set the
requirements.

>From Thomas' patches adding documentation for this:

+1. Placement:
+
+   The SPDX license identifier in kernel files shall be added at the first
+   possible line in a file which can contain a comment.  For the majority
+   or files this is the first line, except for scripts which require the
+   '#!PATH_TO_INTERPRETER' in the first line.  For those scripts the SPDX
+   identifier goes into the second line.
+
+|
+
+2. Style:
+
+   The SPDX license identifier is added in form of a comment.  The comment
+   style depends on the file type:
+
+   ::
+
+      C source:   // SPDX-License-Identifier: <SPDX License Expression>
+      C header:   /* SPDX-License-Identifier: <SPDX License Expression> */
+      ASM:        /* SPDX-License-Identifier: <SPDX License Expression> */
+      scripts:    # SPDX-License-Identifier: <SPDX License Expression>
+      .rst:      .. SPDX-License-Identifier: <SPDX License Expression>
+
+   If a specific tool cannot handle the standard comment style, then the
+   appropriate comment mechanism which the tool accepts shall be used. This
+   is the reason for having the "/\* \*/" style comment in C header
+   files. There was build breakage observed with generated .lds files where
+   'ld' failed to parse the C++ comment. This has been fixed by now, but
+   there are still older assembler tools which cannot handle C++ style
+   comments.

There is additional information in Thomas' patch about the SPDX
identifiers, how to deal with multi-licensed files, etc.  It's
well worth reading before throwing a SPDX tag on a file to make
sure you get the correct tag(s) and expressions.

It's a fixed format.  Tabs and additional spaces that are not in
the format are bad news.

The idea here is (as detailed by Linus) to be able to grep for
the SPDX identifiers using standard Unix tools, sort then and
then eliminate duplicates.  If someone decides to use a tab
after the SPDX-Identifier: rather than a space, then it messes
up "uniq"'s ability to get rid of the duplicates.

As I say, the documentation is there to help people get this right,
so it's well worth reading.  I don't think it's in mainline yet.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
