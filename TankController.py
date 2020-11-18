import wx
  
class TankController(wx.Frame): 
  labels = ['1', '2', '3', 'A', 
            '4', '5', '6', 'B',
            '7', '8', '9', 'C',
            '*', '0', '#', 'D']
  def __init__(self, parent, title): 
    super(TankController, self).__init__(parent, title = title, size = (220,300)) 
    self.InitUI() 
    self.Centre() 
    self.Show()      

  def InitUI(self): 
    panel = wx.Panel(self) 
    panel.Bind(wx.EVT_CHAR, self.Keyboard)

    mainSizer = wx.BoxSizer(wx.VERTICAL)

    lqdSizer = wx.StaticBoxSizer(wx.VERTICAL, panel, label="Liquid Crystal Display (16x2)")
    lqd = wx.StaticText(panel, label = "               X\n               X")
    font = wx.Font(20, wx.FONTFAMILY_TELETYPE, wx.FONTSTYLE_NORMAL, wx.FONTWEIGHT_NORMAL) 
    lqd.SetFont(font) 
    lqdSizer.Add(lqd, 1)
    mainSizer.Add(lqdSizer,1)

    keypadSizer = wx.StaticBoxSizer(wx.VERTICAL, panel, label="Keypad (4x4 Membrane)")

    keypadGrid = wx.GridSizer(4, 4, 5, 5) 
    for each in self.labels: 
      button = wx.Button(panel, label = each)
      button.Bind(wx.EVT_LEFT_UP, self.KeypadEvent)
      keypadGrid.Add(button, 0, wx.EXPAND) 
    keypadSizer.Add(keypadGrid, 1)
    mainSizer.Add(keypadSizer, 2)

    tankSizer = wx.StaticBoxSizer(wx.VERTICAL, panel, label="Tank Simulation")
    tank = wx.StaticText(panel, label = "TANK")
    tankSizer.Add(tank, 1)
    mainSizer.Add(tankSizer, 3)

    panel.SetSizer(mainSizer)
  
  def KeypadEvent(self, event):
    key = event.GetEventObject().GetLabel()
    print("Keypad", key)

  def Keyboard(self, event):
    key = chr(event.GetUnicodeKey()).upper()
    print("Keyboard", key)

app = wx.App() 
TankController(None, title = 'Tank Controller') 
app.MainLoop()