defmodule CodeCidatel.CouseWork.UnixShell do
  @moduledoc """
  This modules mimicks *nix based shell
  """

  def cmd(command) when is_binary(command) do
    if String.contains?(command, "cd") do
      changing_dir(command)
    else
      {result, _} = System.cmd("sh", ["-c", command], stderr_to_stdout: true)
      String.trim(result)
    end
  end

  # check other cd options
  # work on safe rm commands
  # path may not work properly for all cases
  defp changing_dir(command) do
    case String.split(command, " ", trim: true) do
      ["cd"] -> File.cd(home_dir())
      ["cd.."] -> take_one_step_back()
      ["cd", ".."] -> take_one_step_back()
      ["cd", path] -> File.cd(path)
    end
  end

  defp take_one_step_back do
    current_dir()
    |> String.split("/")
    |> List.delete_at(-1)
    |> Enum.join("/")
    |> File.cd()
  end

  defp home_dir do
    {home_dir, _} = System.cmd("sh", ["-c", "echo $HOME"], stderr_to_stdout: true)
    String.trim(home_dir)
  end

  defp current_dir do
    {current_dir, _} = System.cmd("sh", ["-c", "pwd"], stderr_to_stdout: true)
    String.trim(current_dir)
  end
end
