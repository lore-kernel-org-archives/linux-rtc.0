Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C623313E21;
	Mon, 14 Sep 2026 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367770; cv=none; b=YkayzkUGInbaBv18xPYd6Q5hBguh9zMuPuEl2yU5L6Oz8ZjDRzBR78RIaacEarqZ8plpYXtuqbSjwhoXE2iJYJhmtCL2b67p9uN43Lws379+gH8vseKdQrogPaMLsJOA429Y7TB0FM6xMANyX+Z8pvsLO8rT6xdgNyieIc+Balw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367770; c=relaxed/simple;
	bh=yFhqYGpQfv75SCqBqvlbQYEKnesajVnGR2kqp3Gos/Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUSNvwEu6kshAxCqVzIVen9R4R0cfc/HFIm+BBnn5yXSTQBnjtyLId3NxW29bxTNLw/HEwT9z4LXS6zsqzsqSSZXclIZqS6TYzxbM83ef9znnwniXDt6U/x+xYOExDNnOFJs4viA7QPOqv5HLJ1+Q0Yw/A9mGoN0sNEJVoRcJEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj8wTcHX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj8wTcHX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679A51F000FF;
	Mon, 14 Sep 2026 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789367768;
	bh=yFhqYGpQfv75SCqBqvlbQYEKnesajVnGR2kqp3Gos/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lj8wTcHXh1evQi1j7BSnCIqIZyAt6uAvzZQ3/ReDxsQvCrTLqeOYzpTHzXDiGcj+0
	 CSPh4XUM4pSi1D+94VpaojgAJL90Qf87SoAGVH6iPtkkLHczgw3oN+dGOMgJ0+sQt2
	 pQwVdBVAAZ+GIQmJpvmqLZIb+CyLbDMT185tsyAlPwJsz+OrK6/4alD25LSdxaC7nW
	 10+gCdR5gV6St7x3SAJEy6G99rIJop2yltBU/ilH8oztNgou7SaFHPxkgxvfgPqgEs
	 lKxx0SPWkKlt0QVGMSLYolKhsQc2QUBM2eWgh/8qINe51IjsKyvnWM8vixf0O88rKG
	 ng6WYlVGYb6CQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/2] rtc: Add NXP PCF85053 driver support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lakshay Piplani" <lakshay.piplani@nxp.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, robh@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260914062048.3704059-2-lakshay.piplani@nxp.com>
References: <20260914062048.3704059-1-lakshay.piplani@nxp.com>
 <20260914062048.3704059-2-lakshay.piplani@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 06:36:07 +0000
Message-Id: <20260914063608.679A51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> PCF85053 is i2c based RTC which supports timer and calendar
> functionality.
>=20
> Features supported:
> 1. Read/Write time
> 2. Get/Set Alarm
> 3. Wakeup Source
> 4. Generate up to 32768Hz clock output
> 5. Primary/Secondary i2c bus
>=20
> Signed-off-by: Daniel Aguirre <daniel.aguirre@nxp.com>
> Signed-off-by: Pankit Garg <pankit.garg@nxp.com>
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914062048.3704=
059-1-lakshay.piplani@nxp.com?part=3D2

