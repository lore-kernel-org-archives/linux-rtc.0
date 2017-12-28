Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38521 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753277AbdL1Nbj (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 28 Dec 2017 08:31:39 -0500
Date: Thu, 28 Dec 2017 19:01:32 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>,
        Jonathan Corbet <corbet@lwn.net>
Subject: rtc: sysfs: move sysfs interface to Documentation/ABI
Message-ID: <20171228133132.GA3927@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi

In Documentation/rtc.txt, there is a description of the sysfs
interface which could be moved to Documentation/ABI.

Would such a change be useful?

The ABI documentation format looks like the following:

What:          (the full sysfs path of the attribute)
Date:          (date of creation)
KernelVersion: (kernel version it first showed up in)
Contact:       (primary contact)
Description:   (long description on usage)

I am doing this in an exercise to move sysfs ABI interfaces (which are
documented) to their right place i.e. in Documentation/ABI along with the rest.

Aishwarya
