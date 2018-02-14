Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42438 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeBNUgI (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Feb 2018 15:36:08 -0500
Received: by mail-qt0-f196.google.com with SMTP id k25so3359091qtj.9
        for <linux-rtc@vger.kernel.org>; Wed, 14 Feb 2018 12:36:08 -0800 (PST)
Subject: Re: [BUG]: Error accessing realtime clock
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1516839170.2319.35.camel@gmail.com>
 <1518537392.3719.1.camel@gmail.com> <20180213202532.GA30929@piout.net>
 <1518554755.2607.4.camel@gmail.com> <20180213205802.GF30929@piout.net>
 <20180213222025.GA3354@piout.net> <1518566194.3441.3.camel@gmail.com>
 <20180214014516.GB3354@piout.net>
From: Peter Milley <pbmilley@gmail.com>
Message-ID: <2cb961a3-0361-424d-3e84-5cf8c11dc5d6@gmail.com>
Date: Wed, 14 Feb 2018 15:35:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180214014516.GB3354@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

So, I think I've confirmed your suspicion.  I booted Linux Mint with a 
4.10 kernel, and I see that the RTC took 0x70, and I don't see any 
watchdog listed at all.

mint@mint ~ $ uname -a
Linux mint 4.10.0-38-generic #42~16.04.1-Ubuntu SMP Tue Oct 10 16:32:20 
UTC 2017 x86_64 x86_64 x86_64 GNU/Linux

mint@mint ~ $ sudo cat /proc/ioports
0000-0cf7 : PCI Bus 0000:00
   0000-001f : dma1
   0020-0021 : pic1
   0040-0043 : timer0
   0050-0053 : timer1
   0060-0060 : keyboard
   0062-0062 : PNP0C09:00
     0062-0062 : EC data
   0064-0064 : keyboard
   0066-0066 : PNP0C09:00
     0066-0066 : EC cmd
   0070-0077 : rtc0
   0080-008f : dma page reg
   00a0-00a1 : pic2
   00c0-00df : dma2
   00f0-00ff : fpu
   0680-069f : pnp 00:00
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
   164e-164f : pnp 00:00
   1800-18fe : pnp 00:00
     1800-1803 : ACPI PM1a_EVT_BLK
     1804-1805 : ACPI PM1a_CNT_BLK
     1808-180b : ACPI PM_TMR
     1810-1815 : ACPI CPU throttle
     1850-1850 : ACPI PM2_CNT_BLK
     1854-1857 : pnp 00:02
     1880-189f : ACPI GPE0_BLK
   3000-3fff : PCI Bus 0000:01
     3000-30ff : 0000:01:00.0
       3000-30ff : r8169
   4000-403f : 0000:00:02.0
   4040-405f : 0000:00:1f.3
   4060-407f : 0000:00:1f.2
     4060-407f : ahci
   4080-4087 : 0000:00:1f.2
     4080-4087 : ahci
   4088-408f : 0000:00:1f.2
     4088-408f : ahci
   4090-4093 : 0000:00:1f.2
     4090-4093 : ahci
   4094-4097 : 0000:00:1f.2
     4094-4097 : ahci
   ffff-ffff : pnp 00:00
     ffff-ffff : pnp 00:00
       ffff-ffff : pnp 00:00

mint@mint ~ $ sudo cat /proc/iomem
00000000-00000fff : reserved
00001000-0006efff : System RAM
0006f000-0006ffff : reserved
00070000-00087fff : System RAM
00088000-000bffff : reserved
   000a0000-000bffff : PCI Bus 0000:00
000c0000-000c3fff : PCI Bus 0000:00
000c4000-000c7fff : PCI Bus 0000:00
000c8000-000cbfff : PCI Bus 0000:00
000cc000-000cffff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-a56affff : System RAM
a56b0000-a5eaffff : reserved
a5eb0000-aa6befff : System RAM
aa6bf000-aa8befff : reserved
aa8bf000-aaebefff : reserved
aaebf000-aafbefff : ACPI Non-volatile Storage
aafbf000-aaffefff : ACPI Tables
aafff000-aaffffff : System RAM
ab000000-af9fffff : reserved
   aba00000-af9fffff : Graphics Stolen Memory
afa00000-feafffff : PCI Bus 0000:00
   afa10000-afa1ffff : pnp 00:05
   afa20000-afa20fff : pnp 00:05
   b0000000-bfffffff : 0000:00:02.0
   c0000000-c03fffff : 0000:00:02.0
   c0400000-c04fffff : PCI Bus 0000:02
     c0400000-c0401fff : 0000:02:00.0
       c0400000-c0401fff : iwlwifi
   c0500000-c05fffff : PCI Bus 0000:01
     c0500000-c0503fff : 0000:01:00.0
       c0500000-c0503fff : r8169
     c0504000-c0504fff : 0000:01:00.0
       c0504000-c0504fff : r8169
   c0600000-c060ffff : 0000:00:14.0
     c0600000-c060ffff : xhci-hcd
   c0610000-c0613fff : 0000:00:03.0
     c0610000-c0613fff : ICH HD audio
   c0614000-c0617fff : 0000:00:1b.0
     c0614000-c0617fff : ICH HD audio
   c0618000-c061801f : 0000:00:16.0
     c0618000-c061801f : mei_me
   c0619000-c06190ff : 0000:00:1f.3
   c061b000-c061b7ff : 0000:00:1f.2
     c061b000-c061b7ff : ahci
   c061c000-c061c3ff : 0000:00:1d.0
     c061c000-c061c3ff : ehci_hcd
   e0000000-efffffff : PCI MMCONFIG 0000 [bus 00-ff]
     e0000000-efffffff : reserved
       e0000000-efffffff : pnp 00:05
   fe101000-fe112fff : reserved
feb00000-feb0ffff : reserved
fec00000-fec00fff : reserved
   fec00000-fec003ff : IOAPIC 0
fed00000-fee00fff : reserved
   fed00000-fed003ff : HPET 0
     fed00000-fed003ff : PNP0103:00
   fed10000-fed17fff : pnp 00:05
   fed18000-fed18fff : pnp 00:05
   fed19000-fed19fff : pnp 00:05
   fed1c000-fed1ffff : pnp 00:05
   fed20000-fed3ffff : pnp 00:05
   fed90000-fed93fff : pnp 00:05
   fee00000-fee00fff : Local APIC
ff000000-ffffffff : INT0800:00
   ffc00000-ffffffff : reserved
100000000-44f5fffff : System RAM
   1b6400000-1b6cdb828 : Kernel code
   1b6cdb829-1b73a0fbf : Kernel data
   1b75d8000-1b7826fff : Kernel bss
44f600000-44fffffff : RAM buffer



On 02/13/2018 08:45 PM, Alexandre Belloni wrote:
> On 13/02/2018 at 18:56:34 -0500, Peter Milley wrote:
>> Okay, I've booted the new kernel.
>>
>> peter@haven:~$ uname -a
>> Linux haven 4.16.0-rc1+ #32 SMP Tue Feb 13 22:11:39 CET 2018 x86_64
>> x86_64 x86_64 GNU/Linux
>> peter@haven:~$ dmesg | grep -i rtc
>> [    0.045403] RTC time: 23:46:52, date: 02/13/18
>> [    1.368198] rtc_cmos 00:01: RTC can wake from S4
>> [    1.368205] rtc_cmos: drivers/rtc/rtc-cmos.c +679 cmos_do_probe
>> [    1.368235] rtc_cmos: drivers/rtc/rtc-cmos.c +684 cmos_do_probe
>> [    1.368260] rtc_cmos: drivers/rtc/rtc-cmos.c +688 cmos_do_probe
>> [    1.368285] rtc_cmos: 1: 70 8
>> [    1.368302] rtc_cmos: probe of 00:01 failed with error -16
>> [    1.408861] hctosys: unable to open rtc device (rtc0)
>>
> [...]
>
>> And /proc/ioports:
>> peter@haven:~$ sudo cat /proc/ioports
>> 0000-0cf7 : PCI Bus 0000:00
>>    0000-001f : dma1
>>    0020-0021 : pic1
>>    0040-0043 : timer0
>>    0050-0053 : timer1
>>    0060-0060 : keyboard
>>    0062-0062 : PNP0C09:00
>>      0062-0062 : EC data
>>    0064-0064 : keyboard
>>    0066-0066 : PNP0C09:00
>>      0066-0066 : EC cmd
>>    0070-0072 : wdat_wdt
> So I can tell you what is happening but I can't tell you why. You have a
> watchdog at 0x70 (size 2) and the RTC at 0x70 (size 8).
>
> Because the watchdog driver is probed first and it requests the io
> region, when the RTC driver is probed, it fails to request the same
> region.
>
> Maybe your 4.10 kernel didn't have CONFIG_WDAT_WDT (this appeared in
> 4.9).
> I'm afraid, that is as far as I can help, you'd have to ask someone that
> is more knowledgeable about x86 to go further (I've added the wdat_wdt
> driver author in Cc).
>
