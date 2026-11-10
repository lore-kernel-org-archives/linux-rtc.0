Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794352475;
	b=x1nVURlFdrNPBhMuuZ1TIncFXOuVUUXGLCI85c2D9ayV/FJ1QD397CBy5woAShSXUmWI
	 ZfWFHd5JBeum9ohfVB/eGUi+ZPlYKTSSs9+Fs6/QN7TQ8KZ/eyQ7M0ud+WBpZQOiLEH3L
	 HIfWInc+SX7CMtwpZ6LJUsawdvZCA0aRL7WoTfG4JoNC93g6blwuDqerKK1NeVWHevmc0
	 waaW5QW2j67m7ys40vxbjv/ZfcNTBfkYk3gQ7O5rQOd2ztb8lZR13HIdk51cfZOxNsoMF
	 Sr+rI9lhky0x64PN+8vvFTPuSsIBomBixLTlRBXSOUj5WNyYwLqwZIZISgEPiqEFGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794352475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=GaRjxJLStAFn7kRkTlmoATlwOXPiUviJx+B8s4MFeng=;
	b=k88euJRhQZxhMPiwTuYeXU1yVlxCtqZho8zM0/LO5NZB2tOuaoubJIU2QkMeEe4o1set
	 xPEHjOCrCAveCVovNac/2ezVFEHDdZsRsexiil3xJKSlKK3hcSU5P3za7udIRAM2ZTCFN
	 oZM0OCCO3sr+tUZs7ihq/wKozrg9RL2ODHg0ru5NmoGz+IAcGPRQR4P/Wu/FE0nyyIU7+
	 g/cm0qteOsxDHNVTkeaSUz3IXL/MC+dP4Mq02QlfJRwCooN3FsTz6xzjzyLIrGZwXKG6y
	 JdBaH8UHBVvkVJQbo2apWh4jhkinKWMGBCXZzRp7oc01Z1accY2iISlBUZmFW+PwtDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V5/lSF5x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2C606A31C;
	Tue, 10 Nov 2026 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5/lSF5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751351F0093C;
	Tue, 10 Nov 2026 23:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794352475;
	bh=GaRjxJLStAFn7kRkTlmoATlwOXPiUviJx+B8s4MFeng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=V5/lSF5xuJy9h6KtG9TjyDtMUcIPnz4sxpzpfG5rrGBBQkE1CGBxSi2QYYpoJvaJs
	 Mr4y2cilW/JDPlOAAC3MvUZIT0vgktDnBY/jAnRqEfZYdk78zwyc4zAC8+w+134feY
	 wjjEUVhB2w6JQSgadqVob0ESJLA4OSFjnNDGo6f15TbAaWe2aoR2JDQmqEstnfDyZT
	 XcIKzeZgbGC2mqVWde4DkN4S4MnMQIkrVvr/H8a++mASLxTPkJoI7/kNp6wGXHL81k
	 59pbwxr6MQZ/MJyhucvX/1NMkcCmPr3XIz9wrTo8q//CzBsNYdJwBTeG78bqem25+l
	 ZstFC+cJu3gOg==
From: Thomas Gleixner <tglx@kernel.org>
To: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>, John Stultz
 <jstultz@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, linux-rtc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Igor
 Velkov <iav@iav.lv>
Subject: Re: [PATCH RFC 2/3] alarmtimer: Choose the wakeup RTC by sleep
 state and priority
In-Reply-To: <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
References: <20261104-b4-alarmtimer-rtc-priority-v1-0-e996681b8086@iav.lv>
 <20261104-b4-alarmtimer-rtc-priority-v1-2-e996681b8086@iav.lv>
Date: Wed, 11 Nov 2026 00:14:31 +0100
Message-ID: <87qzgsth2g.ffs@fw13>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 04 2026 at 05:54, Igor Velkov via B4 Relay wrote:
> alarmtimer_rtc_add_device() registers a platform device under the first
> RTC that has an alarm and a wakeup-capable parent, and alarmtimer_suspend()
> programs that RTC. On ODROID-HC4 it is meson-vrtc, a register the firmware
> reads when the application processors suspend, with no interrupt in
> Linux, so an alarm set on it does not wake the board from s2idle; the
> board's pcf8563 registers later and is never used.

I'm impressed how creative hardware/firmware people can be...

FYI, the patch fails to apply against

     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core

and violates the tip maintainer coding style requirements

    https://docs.kernel.org/process/maintainer-tip.html

all over the place.

> +/*
> + * Place for @ar in alarmtimer_rtcs, or NULL when an RTC ahead of it would be
> + * chosen over it for every suspend state.
> + */
> +static struct list_head *alarmtimer_rtc_position(const struct alarmtimer_rtc *ar)
> +{
> +	struct alarmtimer_rtc *other;
> +	struct list_head *pos;
> +
> +	lockdep_assert_held(&rtcdev_lock);
> +
> +	list_for_each(pos, &alarmtimer_rtcs) {
> +		other = list_entry(pos, struct alarmtimer_rtc, node);
> +		if (other->priority < ar->priority)
> +			break;

What's this priority check for? Nothing uses it and we are _not_
designing for hypothetical use cases where a platform has a gazillion of
RTCs. It's bad enough that we have to support per suspend state wakeup
sources in the first place.

> +	ar = kzalloc_obj(*ar);
> +	if (!ar)
> +		return -ENOMEM;
> +
> +	ar->rtc = rtc;
> +	device_property_read_u32(parent, "linux,alarmtimer-priority",
> +				 &ar->priority);
> +	listed = device_property_present(parent, "linux,wakeup-states");
> +	for (state = PM_SUSPEND_MIN; state < PM_SUSPEND_MAX; state++) {
> +		ar->wakes_from[state] = !listed ||
> +			device_property_match_string(parent, "linux,wakeup-states",
> +						     alarmtimer_state_names[state]) >= 0;
> +		wakes |= ar->wakes_from[state];
> +	}

This is unreadable garbage and list management is the completely wrong
approach.

You have three suspend states to care about (s2idle, standby, mem) and
you ideally have a RTC device assigned to each state. Whether that's a
single device or different ones does not matter:

struct rtc_wakeup {
	struct rtc_dev		*rtc[PM_SUSPEND_MAX];
        struct rtc_dev		*active_rtc;
        struct rct_timer	timer;
        unsigned long		assigned;
};

static struct rtc_wakeup wakeup_ctl;

register()
	...
        // Reads state list or returns STATES_ALL (0xE) if no list property available
        unsigned long states = parse_wakeup_states(dev);

        // Remove already assigned states
        states &= ~wakeup_ctl.assigned;
        if (!states)
        	return -EBUSY;

  	pdev = platform_device_register_data(dev, "alarmtimer",
  					     PLATFORM_DEVID_AUTO, NULL, 0);

	if (IS_ERR(pdev))
        	return PTR_ERR(pdev);

	if (!try_module_get(rtc->owner)) {
	  	platform_device_unregister(pdev);
        	return -ESRCH;
        }

        get_device(dev);
	device_init_wakeup(&pdev->dev, true);

        for_each_set_bit(state, &states, PM_SUSPEND_MAX)
        	wakeup_ctl.rtcs[state] = dev;

	WRITE_ONCE(wakeup_ctl.assigned, wakeup_ctl.assigned | states);
        return 0;

No allocations, straight forward comprehensible code.

That requires to rework alarmtimer_get_rtcdev() to

bool alarmtimer_has_rtcdev()
{
	return !!READ_ONCE(wakeup_ctl.assigned);
}

But that's fine because with that change nothing needs
alarmtimer_get_rtcdev() outside of the core code anymore.

>  static int alarmtimer_suspend(struct device *dev)
>  {
> +	struct rtc_device *rtc = to_rtc_device(dev->parent);
>  	ktime_t min, now, expires;
> -	struct rtc_device *rtc;
> +	struct alarmtimer_rtc *ar;
>  	struct rtc_time tm;
>  	int i, ret, type;
>  
> +	scoped_guard(spinlock_irqsave, &rtcdev_lock)
> +		ar = alarmtimer_rtc_for_state(pm_suspend_target_state);
> +	if (ar && ar->rtc != rtc)
> +		return 0;

...

> +	/* No RTC wakes the system from this state */
> +	if (!ar)
>  		return 0;

In the upstream code this condition is bogus because if there is a
platform device then there must be a rtc device as well.

Though I understand that with multiple devices you need to somehow
handle the freezer_delta/expires magic even if there is no RTC device
for the current suspend state.

But with the above that's truly incomprehensible and after reading it
three times I still can't convince myself that it is even halfways
correct.

The other thing is that if there is a non-supported state your hackery
fails (contrary to the current code which has the pointless condition
for rtcdev) to evaluate whether there is an alarm armed at all.

If there is an alarm armed then it's sensible to reject the suspend
attempt for the unsupported state. You modeled this after your use case
which does not use the non-supported states, but that's far from being
generally correct, no?

Trying to handle this with magic hacks is not going to fly, but this
can be simply done by avoiding the multi-platform device creation and
just creating one disconnected pseudo device:

struct rtc_wakeup {
	struct rtc_dev		*rtc[PM_SUSPEND_MAX];
        struct platform_device	*pdev;
        struct rtc_dev		*active_rtc;
        struct rct_timer	timer;
        unsigned long		assigned;
};

static struct rtc_wakeup wakeup_ctl;

static bool wakeup_create_pdev(void)
{
	if (!IS_ERR_OR_NULL(wakeup_ctl.pdev))
		return true;

	wakeup_ctl.pdev = platform_device_register_data(NULL, "alarmtimer",
							PLATFORM_DEVID_AUTO, NULL, 0);
	if (IS_ERR(wakeup_ctl.pdev))
        	return false;

	device_init_wakeup(&wakeup_ctl->pdev->dev, true);
        return true;
}

register()
	...
        // Reads state list or returns STATES_ALL (0xE) if no list property available
        unsigned long states = parse_wakeup_states(dev);

        // Remove already assigned states
        states &= ~wakeup_ctl.assigned;
        if (!states)
        	return -EBUSY;

	if (!try_module_get(rtc->owner))
        	return -ESRCH;

	if (!wakeup_create_pdev()) {
        	module_put(rtc->owner);
        	return -ENODEV;
	}                

        get_device(dev);

        for_each_set_bit(state, &states, PM_SUSPEND_MAX)
        	wakeup_ctl.rtcs[state] = dev;

	WRITE_ONCE(wakeup_ctl.assigned, wakeup_ctl.assigned | states);
        return 0;

Then all of this falls into place:

static int alarmtimer_suspend(struct device *unused)
{
	scoped_guard(spinlock_irqsave, &freezer_delta_lock) {
		min = freezer_delta;
		expires = freezer_expires;
		type = freezer_alarmtype;
		freezer_delta = 0;
	}

        // Evaluate the pending alarms
        ...
        
      	if (!alarm_armed)
               	return 0;

	struct rtc_device *rtc = wakeup_ctl.rtcs[pm_suspend_target_state];

        // Handle the case of an unsupported state
	if (!rtc) {
          	pm_wakeup_event(dev, ....);
                return -E$TOBEDEFINED;
        }

        ....

	wakeup_ctl.active_rtc = rtc;
}

and

static int alarmtimer_resume(struct device *unused)
{
	if (!wakeup_ctl.active_rtc)
        	return;

	rtc_timer_cancel(wakeup_ctl.active_rtc, &wakeup_ctl.timer);
	wakeup_ctl.active_rtc = NULL;
}

So this gets _ONE_ suspend() and _ONE_ resume() call and nothing more
and everything falls in place and is comprehensible, no?

One user space visible issue here might be that user space cannot
determine which RTC device is responsible for wakeup. So this needs some
investigation whether user space actually searches for
/sys/.../alarmtimer.xxx

I doubt it, but who the hell knows.

Though the same problem exists when user space suddenly finds more than
one alarmtimer device...

While staring at that code long enough I really got disgusted by this
freezer handling nonsense. That's a horrible hack and want's to be fixed
up _before_ we add multi-rtc wakeup support. The proper thing to do is
to integrate this into the wakeup_ctl infrastructure:

struct freezer_wakeup {
	struct alarm		alarm;
        ktime_t			expires;
};

struct rtc_wakeup {
	struct rtc_dev		*rtc[PM_SUSPEND_MAX];
        struct platform_device	*pdev;
        struct rtc_dev		*active_rtc;
        struct rct_timer	timer;
  	struct freezer_wakeup	freezer[ALARM_NUMTYPE];
        unsigned long		assigned;
};

static struct rtc_wakeup wakeup_ctl;

And obviously initialize that:

static void alarmtimer_freezer_fn(struct alarm *alarm, ktime_t now) { }

static __init ....()
{
	struct freezer_wakeup *f = wakeup_ctl.freezer;

	for (unsigned int t = 0; t < ALARM_NUMTYPE; t++, f++)
		alarm_init(&f->alarm, t, alarmtimer_freezer_fn);
}

But then this whole freezerset() thing boils down to:

static void alarmtimer_freezerset(ktime_t absexp, enum alarmtimer_type type)
{
	if (WARN_ON_ONCE(type >= ALARM_NUMTYPE))
        	return;

	struct freezer_wakeup *f = wakeup_ctl.freezer + type;

	guard(spinlock_irqsave)(&freezer_delta_lock);
	if (f->expires > absexp)
		f->expires = absexp;       
}

And the suspend path gets:

static void alarmtimer_arm_freezer(void)
{
        guard(spinlock_irqsave)(&freezer_delta_lock);

	struct freezer_wakeup *f = wakeup_ctl.freezer;

	for (unsigned int t = 0; t < ALARM_NUMTYPE; t++, f++) {
        	if (f->expires == KTIME_MAX)
                	contine;
                alarm_start_timer(&f->expires, f->alarm, false)
                f->expires = KTIME_MAX;
        }
}

static ktime_t alarmtimer_getnext(struct alarm_base *base)
{
	guard(spinlock_irqsave)(&base->lock);

	struct timerqueue_node *next = timerqueue_getnext(&base->timerqueue);

        return next ? next->expires : KTIME_MAX;
}

static int alarmtimer_suspend(struct device *unused)
{
	alarmtimer_arm_freezer();
        ...

	struct alarm_base *base = alarm_bases;
	ktime_t expires_rel = KTIME_MAX;
        enum alarmtimer_type type;

	for (unsigned int t = 0; t < ALARM_NUMTYPE; t++, base++) {
		ktime_t expabs = alarmtimer_getnext(base);

		if (expabs == KTIME_MAX)
                	continue;

		ktime_t exprel = ktime_sub(expires, base->get_ktime());

		if (exprel < expires_rel) {
                	expires_rel = exprel;
                        type = t;
                }
	}

        // Remove the freezer timers from the queue
	alarmtimer_disarm_freezer();

	// Stop right here if no alarm set
        if (expires_rel == KTIME_MAX)
		return 0;
        ...
}

I'm sure that I missed something there, but you get the general idea.

Thanks,

        tglx
